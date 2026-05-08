<?php

namespace App\Controller;

use App\Entity\ContactMessage;
use App\Entity\Project;
use App\Entity\ProjectImage;
use App\Entity\Preuve;
use App\Entity\Education;
use App\Entity\Experience;
use App\Entity\Skill;
use App\Entity\Technology;
use App\Entity\Internship;
use App\Repository\ContactMessageRepository;
use App\Repository\ProjectRepository;
use App\Repository\ProjectImageRepository;
use App\Repository\PreuveRepository;
use App\Repository\EducationRepository;
use App\Repository\ExperienceRepository;
use App\Repository\SkillRepository;
use App\Repository\TechnologyRepository;
use App\Repository\InternshipRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
#[IsGranted('ROLE_ADMIN')]
class AdminController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ContactMessageRepository $contactMessageRepository,
        private ProjectRepository $projectRepository,
        private ProjectImageRepository $projectImageRepository,
        private PreuveRepository $preuveRepository,
        private EducationRepository $educationRepository,
        private ExperienceRepository $experienceRepository,
        private SkillRepository $skillRepository,
        private TechnologyRepository $technologyRepository,
        private InternshipRepository $internshipRepository
    ) {}

    #[Route('/', name: 'admin_dashboard')]
    public function dashboard(): Response
    {
        // Messages stats
        $unreadMessages = $this->contactMessageRepository->countUnread();
        $totalMessages = count($this->contactMessageRepository->findAll());
        $recentMessages = $this->contactMessageRepository->findBy([], ['createdAt' => 'DESC'], 5);

        // Count all entities
        $totalProjects = count($this->projectRepository->findAll());
        $totalEducation = count($this->educationRepository->findAll());
        $totalExperiences = count($this->experienceRepository->findAll());
        $totalSkills = count($this->skillRepository->findAll());
        $totalInternships = count($this->internshipRepository->findAll());
        $totalTechnologies = count($this->technologyRepository->findAll());

        // Visible entities count
        $visibleProjects = count($this->projectRepository->findBy(['isVisible' => true]));
        $visibleEducation = count($this->educationRepository->findBy(['isVisible' => true]));
        $visibleExperiences = count($this->experienceRepository->findBy(['isVisible' => true]));
        $visibleSkills = count($this->skillRepository->findBy(['isVisible' => true]));
        $visibleInternships = count($this->internshipRepository->findBy(['isVisible' => true]));

        return $this->render('admin/dashboard.html.twig', [
            'unreadMessages' => $unreadMessages,
            'totalMessages' => $totalMessages,
            'totalProjects' => $totalProjects,
            'totalEducation' => $totalEducation,
            'totalExperiences' => $totalExperiences,
            'totalSkills' => $totalSkills,
            'totalInternships' => $totalInternships,
            'totalTechnologies' => $totalTechnologies,
            'visibleProjects' => $visibleProjects,
            'visibleEducation' => $visibleEducation,
            'visibleExperiences' => $visibleExperiences,
            'visibleSkills' => $visibleSkills,
            'visibleInternships' => $visibleInternships,
            'recentMessages' => $recentMessages,
        ]);
    }

    // ==================== MESSAGES ====================

    #[Route('/messages', name: 'admin_messages')]
    public function messages(): Response
    {
        $messages = $this->contactMessageRepository->findAllOrderedByDate();

        return $this->render('admin/messages.html.twig', [
            'messages' => $messages,
        ]);
    }

    #[Route('/messages/{id}/read', name: 'admin_message_mark_read', methods: ['POST'])]
    public function markMessageAsRead(int $id): JsonResponse
    {
        $message = $this->contactMessageRepository->find($id);

        if (!$message) {
            return new JsonResponse(['success' => false, 'error' => 'Message non trouvé'], 404);
        }

        $message->setIsRead(true);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    #[Route('/messages/{id}/delete', name: 'admin_message_delete', methods: ['POST'])]
    public function deleteMessage(int $id): JsonResponse
    {
        $message = $this->contactMessageRepository->find($id);

        if (!$message) {
            return new JsonResponse(['success' => false, 'error' => 'Message non trouvé'], 404);
        }

        $this->entityManager->remove($message);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    // ==================== PROJECTS ====================

    #[Route('/projects', name: 'admin_projects')]
    public function projects(): Response
    {
        $projects = $this->projectRepository->findAllOrdered();

        return $this->render('admin/projects.html.twig', [
            'projects' => $projects,
        ]);
    }

    #[Route('/projects/new', name: 'admin_project_new', methods: ['GET', 'POST'])]
    public function newProject(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $project = new Project();
            $this->populateProjectFromRequest($project, $request);

            $this->entityManager->persist($project);
            $this->entityManager->flush();

            $this->addFlash('success', 'Projet créé avec succès !');
            return $this->redirectToRoute('admin_projects');
        }

        return $this->render('admin/project_form.html.twig', [
            'project' => null,
        ]);
    }

    #[Route('/projects/{id}/edit', name: 'admin_project_edit', methods: ['GET', 'POST'])]
    public function editProject(int $id, Request $request): Response
    {
        $project = $this->projectRepository->find($id);

        if (!$project) {
            throw $this->createNotFoundException('Projet non trouvé');
        }

        if ($request->isMethod('POST')) {
            $this->populateProjectFromRequest($project, $request);
            $project->setUpdatedAt(new \DateTimeImmutable());

            $this->entityManager->flush();

            $this->addFlash('success', 'Projet modifié avec succès !');
            return $this->redirectToRoute('admin_projects');
        }

        return $this->render('admin/project_form.html.twig', [
            'project' => $project,
        ]);
    }

    #[Route('/projects/{id}/delete', name: 'admin_project_delete', methods: ['POST'])]
    public function deleteProject(int $id): JsonResponse
    {
        $project = $this->projectRepository->find($id);

        if (!$project) {
            return new JsonResponse(['success' => false, 'error' => 'Projet non trouvé'], 404);
        }

        $this->entityManager->remove($project);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateProjectFromRequest(Project $project, Request $request): void
    {
        $project->setTitle($request->request->get('title'));
        $project->setShortDescription($request->request->get('shortDescription'));
        $project->setFullDescription($request->request->get('fullDescription'));
        $project->setImage($request->request->get('image'));
        $project->setGithubUrl($request->request->get('githubUrl'));
        $project->setLiveUrl($request->request->get('liveUrl'));
        $project->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $project->setIsVisible($request->request->get('isVisible') === '1');

        // New fields
        $project->setType($request->request->get('type'));
        $project->setCategory($request->request->get('category'));

        // Start date
        $startDate = $request->request->get('startDate');
        if ($startDate) {
            $project->setStartDate(new \DateTimeImmutable($startDate));
        } else {
            $project->setStartDate(null);
        }

        // End date
        $endDate = $request->request->get('endDate');
        if ($endDate) {
            $project->setEndDate(new \DateTimeImmutable($endDate));
        } else {
            $project->setEndDate(null);
        }

        // Technologies - now using ManyToMany relation
        $technologyIds = $request->request->all('technologies') ?? [];

        // Clear existing technologies
        foreach ($project->getTechnologies()->toArray() as $tech) {
            $project->removeTechnology($tech);
        }

        // Add selected technologies
        foreach ($technologyIds as $techId) {
            $technology = $this->technologyRepository->find($techId);
            if ($technology) {
                $project->addTechnology($technology);
            }
        }

        // Skills - using ManyToMany relation
        $skillIds = $request->request->all('skills') ?? [];

        // Clear existing skills
        foreach ($project->getSkills()->toArray() as $skill) {
            $project->removeSkill($skill);
        }

        // Add selected skills
        foreach ($skillIds as $skillId) {
            $skill = $this->skillRepository->find($skillId);
            if ($skill) {
                $project->addSkill($skill);
            }
        }
    }

    // ==================== PREUVES ====================

    #[Route('/project/{id}/preuves', name: 'admin_project_preuves', methods: ['GET'])]
    public function getProjectPreuves(int $id): JsonResponse
    {
        $preuves = $this->preuveRepository->findByProject($id);

        $data = array_map(function($preuve) {
            return [
                'id' => $preuve->getId(),
                'title' => $preuve->getTitle(),
                'description' => $preuve->getDescription(),
                'filename' => $preuve->getFilename(),
                'url' => '/uploads/' . $preuve->getFilename(),
                'skillId' => $preuve->getSkill()?->getId(),
                'skillName' => $preuve->getSkill()?->getName(),
                'skillCode' => $preuve->getSkill()?->getCode(),
                'displayOrder' => $preuve->getDisplayOrder(),
            ];
        }, $preuves);

        return new JsonResponse($data);
    }

    #[Route('/project/{id}/preuves/add', name: 'admin_project_preuve_add', methods: ['POST'])]
    public function addProjectPreuve(int $id, Request $request): JsonResponse
    {
        $project = $this->projectRepository->find($id);
        if (!$project) {
            return new JsonResponse(['success' => false, 'error' => 'Projet non trouvé'], 404);
        }

        $title = $request->request->get('title');
        $description = $request->request->get('description');
        $filename = $request->request->get('filename');
        $skillId = $request->request->get('skillId');

        if (!$title || !$filename || !$skillId) {
            return new JsonResponse(['success' => false, 'error' => 'Titre, fichier et compétence requis'], 400);
        }

        $skill = $this->skillRepository->find($skillId);
        if (!$skill) {
            return new JsonResponse(['success' => false, 'error' => 'Compétence non trouvée'], 404);
        }

        $preuve = new Preuve();
        $preuve->setProject($project);
        $preuve->setSkill($skill);
        $preuve->setTitle($title);
        $preuve->setDescription($description);
        $preuve->setFilename($filename);

        $this->entityManager->persist($preuve);
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'preuve' => [
                'id' => $preuve->getId(),
                'title' => $preuve->getTitle(),
                'description' => $preuve->getDescription(),
                'filename' => $preuve->getFilename(),
                'url' => '/uploads/' . $preuve->getFilename(),
                'skillId' => $skill->getId(),
                'skillName' => $skill->getName(),
                'skillCode' => $skill->getCode(),
                'displayOrder' => $preuve->getDisplayOrder(),
            ]
        ]);
    }

    #[Route('/project/{projectId}/preuves/{preuveId}', name: 'admin_project_preuve_delete', methods: ['DELETE'])]
    public function deleteProjectPreuve(int $projectId, int $preuveId): JsonResponse
    {
        $preuve = $this->preuveRepository->find($preuveId);

        if (!$preuve || $preuve->getProject()?->getId() !== $projectId) {
            return new JsonResponse(['success' => false, 'error' => 'Preuve non trouvée'], 404);
        }

        $this->entityManager->remove($preuve);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    // ==================== PROJECT IMAGES ====================

    #[Route('/project/{id}/images', name: 'admin_project_images', methods: ['GET'])]
    public function getProjectImages(int $id): JsonResponse
    {
        $images = $this->projectImageRepository->findByProject($id);

        $data = array_map(function($image) {
            return [
                'id' => $image->getId(),
                'filename' => $image->getFilename(),
                'url' => '/uploads/' . $image->getFilename(),
                'displayOrder' => $image->getDisplayOrder(),
            ];
        }, $images);

        return new JsonResponse($data);
    }

    #[Route('/project/{id}/images/add', name: 'admin_project_image_add', methods: ['POST'])]
    public function addProjectImage(int $id, Request $request): JsonResponse
    {
        $project = $this->projectRepository->find($id);
        if (!$project) {
            return new JsonResponse(['success' => false, 'error' => 'Projet non trouvé'], 404);
        }

        $filename = $request->request->get('filename');
        if (!$filename) {
            return new JsonResponse(['success' => false, 'error' => 'Nom de fichier requis'], 400);
        }

        // Get the next display order
        $maxOrder = 0;
        foreach ($project->getImages() as $img) {
            if ($img->getDisplayOrder() > $maxOrder) {
                $maxOrder = $img->getDisplayOrder();
            }
        }

        $projectImage = new ProjectImage();
        $projectImage->setProject($project);
        $projectImage->setFilename($filename);
        $projectImage->setDisplayOrder($maxOrder + 1);

        $this->entityManager->persist($projectImage);
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'image' => [
                'id' => $projectImage->getId(),
                'filename' => $projectImage->getFilename(),
                'url' => '/uploads/' . $projectImage->getFilename(),
                'displayOrder' => $projectImage->getDisplayOrder(),
            ]
        ]);
    }

    #[Route('/project/{projectId}/images/{imageId}', name: 'admin_project_image_delete', methods: ['DELETE'])]
    public function deleteProjectImage(int $projectId, int $imageId): JsonResponse
    {
        $image = $this->projectImageRepository->find($imageId);

        if (!$image || $image->getProject()->getId() !== $projectId) {
            return new JsonResponse(['success' => false, 'error' => 'Image non trouvée'], 404);
        }

        $this->entityManager->remove($image);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    // ==================== EDUCATION ====================

    #[Route('/education', name: 'admin_education')]
    public function education(): Response
    {
        $educations = $this->educationRepository->findAllOrdered();

        return $this->render('admin/education.html.twig', [
            'educations' => $educations,
        ]);
    }

    #[Route('/education/new', name: 'admin_education_new', methods: ['GET', 'POST'])]
    public function newEducation(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $education = new Education();
            $this->populateEducationFromRequest($education, $request);

            $this->entityManager->persist($education);
            $this->entityManager->flush();

            $this->addFlash('success', 'Formation ajoutée avec succès !');
            return $this->redirectToRoute('admin_education');
        }

        return $this->render('admin/education_form.html.twig', [
            'education' => null,
        ]);
    }

    #[Route('/education/{id}/edit', name: 'admin_education_edit', methods: ['GET', 'POST'])]
    public function editEducation(int $id, Request $request): Response
    {
        $education = $this->educationRepository->find($id);

        if (!$education) {
            throw $this->createNotFoundException('Formation non trouvée');
        }

        if ($request->isMethod('POST')) {
            $this->populateEducationFromRequest($education, $request);
            $this->entityManager->flush();

            $this->addFlash('success', 'Formation modifiée avec succès !');
            return $this->redirectToRoute('admin_education');
        }

        return $this->render('admin/education_form.html.twig', [
            'education' => $education,
        ]);
    }

    #[Route('/education/{id}/delete', name: 'admin_education_delete', methods: ['POST'])]
    public function deleteEducation(int $id): JsonResponse
    {
        $education = $this->educationRepository->find($id);

        if (!$education) {
            return new JsonResponse(['success' => false, 'error' => 'Formation non trouvée'], 404);
        }

        $this->entityManager->remove($education);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateEducationFromRequest(Education $education, Request $request): void
    {
        $education->setDegree($request->request->get('degree'));
        $education->setInstitution($request->request->get('institution'));
        $education->setStartDate($request->request->get('startDate'));
        $education->setEndDate($request->request->get('endDate'));
        $education->setDescription($request->request->get('description'));
        $education->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $education->setIsVisible((bool) $request->request->get('isVisible', true));
    }

    // ==================== EXPERIENCE ====================

    #[Route('/experience', name: 'admin_experience')]
    public function experience(): Response
    {
        $experiences = $this->experienceRepository->findAllOrdered();

        return $this->render('admin/experience.html.twig', [
            'experiences' => $experiences,
        ]);
    }

    #[Route('/experience/new', name: 'admin_experience_new', methods: ['GET', 'POST'])]
    public function newExperience(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $experience = new Experience();
            $this->populateExperienceFromRequest($experience, $request);

            $this->entityManager->persist($experience);
            $this->entityManager->flush();

            $this->addFlash('success', 'Expérience ajoutée avec succès !');
            return $this->redirectToRoute('admin_experience');
        }

        return $this->render('admin/experience_form.html.twig', [
            'experience' => null,
        ]);
    }

    #[Route('/experience/{id}/edit', name: 'admin_experience_edit', methods: ['GET', 'POST'])]
    public function editExperience(int $id, Request $request): Response
    {
        $experience = $this->experienceRepository->find($id);

        if (!$experience) {
            throw $this->createNotFoundException('Expérience non trouvée');
        }

        if ($request->isMethod('POST')) {
            $this->populateExperienceFromRequest($experience, $request);
            $this->entityManager->flush();

            $this->addFlash('success', 'Expérience modifiée avec succès !');
            return $this->redirectToRoute('admin_experience');
        }

        return $this->render('admin/experience_form.html.twig', [
            'experience' => $experience,
        ]);
    }

    #[Route('/experience/{id}/delete', name: 'admin_experience_delete', methods: ['POST'])]
    public function deleteExperience(int $id): JsonResponse
    {
        $experience = $this->experienceRepository->find($id);

        if (!$experience) {
            return new JsonResponse(['success' => false, 'error' => 'Expérience non trouvée'], 404);
        }

        $this->entityManager->remove($experience);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateExperienceFromRequest(Experience $experience, Request $request): void
    {
        $experience->setPosition($request->request->get('position'));
        $experience->setCompany($request->request->get('company'));
        $experience->setStartDate($request->request->get('startDate'));
        $experience->setEndDate($request->request->get('endDate'));
        $experience->setDescription($request->request->get('description'));
        $experience->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $experience->setIsVisible((bool) $request->request->get('isVisible', true));

        // Responsibilities as JSON
        $responsibilities = $request->request->get('responsibilities', '');
        if ($responsibilities) {
            $respArray = array_filter(array_map('trim', explode("\n", $responsibilities)));
            $experience->setResponsibilities($respArray);
        }
    }

    // ==================== SKILLS ====================

    #[Route('/skills', name: 'admin_skills')]
    public function skills(): Response
    {
        $skills = $this->skillRepository->findAllOrdered();

        return $this->render('admin/skills.html.twig', [
            'skills' => $skills,
        ]);
    }

    #[Route('/skills/new', name: 'admin_skill_new', methods: ['GET', 'POST'])]
    public function newSkill(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $skill = new Skill();
            $this->populateSkillFromRequest($skill, $request);

            $this->entityManager->persist($skill);
            $this->entityManager->flush();

            $this->addFlash('success', 'Compétence ajoutée avec succès !');
            return $this->redirectToRoute('admin_skills');
        }

        return $this->render('admin/skill_form.html.twig', [
            'skill' => null,
        ]);
    }

    #[Route('/skills/{id}/edit', name: 'admin_skill_edit', methods: ['GET', 'POST'])]
    public function editSkill(int $id, Request $request): Response
    {
        $skill = $this->skillRepository->find($id);

        if (!$skill) {
            throw $this->createNotFoundException('Compétence non trouvée');
        }

        if ($request->isMethod('POST')) {
            $this->populateSkillFromRequest($skill, $request);
            $this->entityManager->flush();

            $this->addFlash('success', 'Compétence modifiée avec succès !');
            return $this->redirectToRoute('admin_skills');
        }

        return $this->render('admin/skill_form.html.twig', [
            'skill' => $skill,
        ]);
    }

    #[Route('/skills/{id}/delete', name: 'admin_skill_delete', methods: ['POST'])]
    public function deleteSkill(int $id): JsonResponse
    {
        $skill = $this->skillRepository->find($id);

        if (!$skill) {
            return new JsonResponse(['success' => false, 'error' => 'Compétence non trouvée'], 404);
        }

        $this->entityManager->remove($skill);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateSkillFromRequest(Skill $skill, Request $request): void
    {
        $skill->setName($request->request->get('name'));
        $skill->setCode($request->request->get('code'));
        $skill->setDescription($request->request->get('description'));
        $skill->setIcon($request->request->get('icon'));
        $skill->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $skill->setIsVisible((bool) $request->request->get('isVisible', true));
    }

    // ==================== TECHNOLOGIES ====================

    #[Route('/technologies', name: 'admin_technologies')]
    public function technologies(): Response
    {
        $technologies = $this->technologyRepository->findAllOrdered();

        return $this->render('admin/technologies.html.twig', [
            'technologies' => $technologies,
        ]);
    }

    #[Route('/technologies/new', name: 'admin_technology_new', methods: ['GET', 'POST'])]
    public function newTechnology(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $technology = new Technology();
            $this->populateTechnologyFromRequest($technology, $request);

            $this->entityManager->persist($technology);
            $this->entityManager->flush();

            $this->addFlash('success', 'Technologie ajoutée avec succès !');
            return $this->redirectToRoute('admin_technologies');
        }

        return $this->render('admin/technology_form.html.twig', [
            'technology' => null,
        ]);
    }

    #[Route('/technologies/{id}/edit', name: 'admin_technology_edit', methods: ['GET', 'POST'])]
    public function editTechnology(int $id, Request $request): Response
    {
        $technology = $this->technologyRepository->find($id);

        if (!$technology) {
            throw $this->createNotFoundException('Technologie non trouvée');
        }

        if ($request->isMethod('POST')) {
            $this->populateTechnologyFromRequest($technology, $request);
            $this->entityManager->flush();

            $this->addFlash('success', 'Technologie modifiée avec succès !');
            return $this->redirectToRoute('admin_technologies');
        }

        return $this->render('admin/technology_form.html.twig', [
            'technology' => $technology,
        ]);
    }

    #[Route('/technologies/{id}/delete', name: 'admin_technology_delete', methods: ['POST'])]
    public function deleteTechnology(int $id): JsonResponse
    {
        $technology = $this->technologyRepository->find($id);

        if (!$technology) {
            return new JsonResponse(['success' => false, 'error' => 'Technologie non trouvée'], 404);
        }

        $this->entityManager->remove($technology);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    #[Route('/technologies/api/list', name: 'admin_technologies_api_list', methods: ['GET'])]
    public function technologiesApiList(): JsonResponse
    {
        $technologies = $this->technologyRepository->findAllOrdered();

        $data = array_map(function($tech) {
            return [
                'id' => $tech->getId(),
                'name' => $tech->getName(),
                'slug' => $tech->getSlug(),
                'icon' => $tech->getIcon(),
            ];
        }, $technologies);

        return new JsonResponse($data);
    }

    #[Route('/skills/api/list', name: 'admin_skills_api_list', methods: ['GET'])]
    public function skillsApiList(): JsonResponse
    {
        $skills = $this->skillRepository->findAllOrdered();

        $data = array_map(function($skill) {
            return [
                'id' => $skill->getId(),
                'name' => $skill->getName(),
                'code' => $skill->getCode(),
                'description' => $skill->getDescription(),
            ];
        }, $skills);

        return new JsonResponse($data);
    }

    private function populateTechnologyFromRequest(Technology $technology, Request $request): void
    {
        $name = $request->request->get('name');
        $technology->setName($name);

        // Generate slug from name if not provided
        $slug = $request->request->get('slug');
        if (!$slug) {
            $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
        }
        $technology->setSlug($slug);

        $technology->setIcon($request->request->get('icon'));
        $technology->setDisplayOrder((int) $request->request->get('displayOrder', 0));
    }

    // ==================== INTERNSHIPS ====================

    #[Route('/internships', name: 'admin_internships')]
    public function internships(): Response
    {
        $internships = $this->internshipRepository->findAllOrdered();

        return $this->render('admin/internships.html.twig', [
            'internships' => $internships,
        ]);
    }

    #[Route('/internships/new', name: 'admin_internship_new', methods: ['GET', 'POST'])]
    public function newInternship(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $internship = new Internship();
            $this->populateInternshipFromRequest($internship, $request);

            $this->entityManager->persist($internship);
            $this->entityManager->flush();

            $this->addFlash('success', 'Stage créé avec succès !');
            return $this->redirectToRoute('admin_internships');
        }

        $projects = $this->projectRepository->findAll();

        return $this->render('admin/internship_form.html.twig', [
            'internship' => null,
            'projects' => $projects,
        ]);
    }

    #[Route('/internships/{id}/edit', name: 'admin_internship_edit', methods: ['GET', 'POST'])]
    public function editInternship(int $id, Request $request): Response
    {
        $internship = $this->internshipRepository->find($id);

        if (!$internship) {
            throw $this->createNotFoundException('Stage non trouvé');
        }

        if ($request->isMethod('POST')) {
            $this->populateInternshipFromRequest($internship, $request);
            $this->entityManager->flush();

            $this->addFlash('success', 'Stage modifié avec succès !');
            return $this->redirectToRoute('admin_internships');
        }

        $projects = $this->projectRepository->findAll();

        return $this->render('admin/internship_form.html.twig', [
            'internship' => $internship,
            'projects' => $projects,
        ]);
    }

    #[Route('/internships/{id}/delete', name: 'admin_internship_delete', methods: ['POST'])]
    public function deleteInternship(int $id): JsonResponse
    {
        $internship = $this->internshipRepository->find($id);

        if (!$internship) {
            return new JsonResponse(['success' => false, 'error' => 'Stage non trouvé'], 404);
        }

        $this->entityManager->remove($internship);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateInternshipFromRequest(Internship $internship, Request $request): void
    {
        $internship->setTitle($request->request->get('title'));
        $internship->setCompany($request->request->get('company'));

        // Handle start date
        $startDateString = $request->request->get('startDate');
        if ($startDateString) {
            try {
                $startDate = new \DateTimeImmutable($startDateString);
                $internship->setStartDate($startDate);
            } catch (\Exception $e) {
                // If date parsing fails, keep existing value or set to null
            }
        }

        // Handle end date (can be null for "En cours")
        $endDateString = $request->request->get('endDate');
        if ($endDateString) {
            try {
                $endDate = new \DateTimeImmutable($endDateString);
                $internship->setEndDate($endDate);
            } catch (\Exception $e) {
                // If date parsing fails, set to null (En cours)
                $internship->setEndDate(null);
            }
        } else {
            $internship->setEndDate(null);
        }

        $internship->setShortDescription($request->request->get('shortDescription'));
        $internship->setFullDescription($request->request->get('fullDescription'));
        $internship->setYear((int) $request->request->get('year'));
        $internship->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $internship->setIsVisible($request->request->get('isVisible') === '1');

        // Handle logo - now using media filename (not full path)
        $logoFilename = $request->request->get('companyLogo');
        if ($logoFilename) {
            $internship->setCompanyLogo($logoFilename);
        }

        // Handle tasks (JSON array from textarea)
        $tasksText = $request->request->get('tasks', '');
        if ($tasksText) {
            $tasksArray = array_filter(array_map('trim', explode("\n", $tasksText)));
            $internship->setTasks($tasksArray);
        } else {
            $internship->setTasks([]);
        }

        // Handle projects relationship (ManyToMany)
        $projectIds = $request->request->all('projects') ?? [];

        // Clear existing projects
        foreach ($internship->getProjects() as $project) {
            $internship->removeProject($project);
        }

        // Add selected projects
        foreach ($projectIds as $projectId) {
            $project = $this->projectRepository->find($projectId);
            if ($project) {
                $internship->addProject($project);
            }
        }

        $internship->setUpdatedAt(new \DateTimeImmutable());
    }
}
